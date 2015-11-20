
#include <string>
#include <utility>

#include <picojson.h>

#include "convert.hpp"
#include "func_store.hpp"
#include "process.hpp"

namespace processwarp {

static const FuncStore::NormalProp DUMMY_PROP = {};
static const BuiltinFuncParam DUMMY_BUILTIN_PARAM = {.ptr = nullptr};

//
FuncStore::FuncStore(vaddr_t addr_,
                     FuncType type_,
                     const Symbols::Symbol& name_,
                     vaddr_t ret_type_,
                     unsigned int arg_num_,
                     bool is_var_arg_,
                     const NormalProp& normal_prop_,
                     const builtin_func_t& builtin_,
                     const BuiltinFuncParam& builtin_param_) :
    addr(addr_),
    type(type_),
    name(name_),
    ret_type(ret_type_),
    arg_num(arg_num_),
    is_var_arg(is_var_arg_),
    normal_prop(normal_prop_),
    builtin(builtin_),
    builtin_param(builtin_param_),
    external(nullptr) {
}

// Allocate a new normal function to memory.
void FuncStore::alloc_normal(VMemory::Accessor& memory,
                             vaddr_t addr,
                             const Symbols::Symbol& name,
                             vaddr_t ret_type,
                             unsigned int arg_num,
                             bool is_var_arg,
                             const NormalProp& normal_prop) {
  picojson::object js_func;
  picojson::array js_code;

  js_func.insert(std::make_pair("program_type", Convert::int2json<uint8_t>(PT_NORMAL)));
  js_func.insert(std::make_pair("name", picojson::value(name.str())));
  js_func.insert(std::make_pair("ret_type", Convert::vaddr2json(ret_type)));
  js_func.insert(std::make_pair("arg_num", Convert::int2json<unsigned int>(arg_num)));
  js_func.insert(std::make_pair("is_var_arg", Convert::bool2json(is_var_arg)));
  js_func.insert(std::make_pair("stack_size",
                                Convert::int2json<unsigned int>(normal_prop.stack_size)));
  js_func.insert(std::make_pair("k", Convert::vaddr2json(normal_prop.k)));
  for (auto code : normal_prop.code) {
    js_code.push_back(Convert::code2json(code));
  }
  js_func.insert(std::make_pair("code", picojson::value(js_code)));

  memory.set_program_area(addr, picojson::value(js_func).serialize());
}

// Allocate a new external function to memory.
void FuncStore::alloc_external(VMemory::Accessor& memory,
                               vaddr_t addr,
                               const Symbols::Symbol& name,
                               vaddr_t ret_type,
                               unsigned int arg_num,
                               bool is_var_arg) {
  picojson::object js_func;

  js_func.insert(std::make_pair("program_type", Convert::int2json<uint8_t>(PT_EXTERNAL)));
  js_func.insert(std::make_pair("name", picojson::value(name.str())));
  js_func.insert(std::make_pair("ret_type", Convert::vaddr2json(ret_type)));
  js_func.insert(std::make_pair("arg_num", Convert::int2json<unsigned int>(arg_num)));
  js_func.insert(std::make_pair("is_var_arg", Convert::bool2json(is_var_arg)));

  memory.set_program_area(addr, picojson::value(js_func).serialize());
}

// Read out function information from memory.
std::unique_ptr<FuncStore> FuncStore::read(Process& proc,
                                           VMemory::Accessor& memory,
                                           vaddr_t addr) {
  picojson::value js_tmp;
  std::istringstream is(memory.get_program_area(addr));
  std::string err = picojson::parse(js_tmp, is);
  if (!err.empty()) {
    /// @todo error
    assert(false);
  }
  picojson::object& js_func = js_tmp.get<picojson::object>();

  ProgramType pt = static_cast<ProgramType>(Convert::json2int<uint8_t>(js_func.at("program_type")));
  std::string name = js_func.at("name").get<std::string>();
  vaddr_t ret_type = Convert::json2vaddr(js_func.at("ret_type"));
  unsigned int arg_num = Convert::json2int<unsigned int>(js_func.at("arg_num"));
  bool is_var_arg = Convert::json2bool(js_func.at("is_var_arg"));

  if (pt == PT_NORMAL) {
    picojson::array& js_code = js_func.at("code").get<picojson::array>();
    NormalProp prop;

    prop.stack_size = Convert::json2int<unsigned int>(js_func.at("stack_size"));
    prop.k = Convert::json2vaddr(js_func.at("k"));
    prop.code.resize(js_code.size());
    for (unsigned int i = 0; i < js_code.size(); i ++) {
      prop.code.at(i) = Convert::json2code(js_code.at(i));
    }

    return std::unique_ptr<FuncStore>
        (new FuncStore(addr,
                       FC_NORMAL,
                       proc.symbols.get(name),
                       ret_type,
                       arg_num,
                       is_var_arg,
                       prop,
                       nullptr,
                       DUMMY_BUILTIN_PARAM));
  } else if (pt == PT_EXTERNAL) {
    if (proc.builtin_funcs.find(name) != proc.builtin_funcs.end()) {
      const std::pair<builtin_func_t, BuiltinFuncParam>& bi_info =
          proc.builtin_funcs.at(name);

      return std::unique_ptr<FuncStore>
          (new FuncStore(addr,
                         FC_BUILTIN,
                         proc.symbols.get(name),
                         ret_type,
                         arg_num,
                         is_var_arg,
                         DUMMY_PROP,
                         bi_info.first,
                         bi_info.second));
    } else {
      return std::unique_ptr<FuncStore>
          (new FuncStore(addr,
                         FC_NATIVE,
                         proc.symbols.get(name),
                         ret_type,
                         arg_num,
                         is_var_arg,
                         DUMMY_PROP,
                         nullptr,
                         DUMMY_BUILTIN_PARAM));
    }

  } else {
    /// @todo error
    assert(false);
    return std::unique_ptr<FuncStore>(nullptr);
  }
}
}  // namespace processwarp
