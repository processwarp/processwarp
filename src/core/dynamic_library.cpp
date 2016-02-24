
#include <string>

#include "dynamic_library.hpp"
#include "error.hpp"

#ifndef EMSCRIPTEN
namespace processwarp {

#ifdef _WIN32
/**
 * Open library by dynamic loading for windows environment.
 * @param fname Filename for loading.
 * @return Handler of library.
 */
DynamicLibrary::lib_handler_t DynamicLibrary::open_lib(const std::string& fname) {
  lib_handler_t lib = LoadLibrary(fname.c_str());
  if (!lib) {
    throw_error_message(Error::EXT_LIBRARY, fname);
  }
  return lib;
}

/**
 * Get the function by a loading library for windows environment.
 * @param handler Handler of library.
 * @param name Function symbol name.
 * @return Pointer to function that has loaded.
 */
DynamicLibrary::external_func_t DynamicLibrary::get_func(lib_handler_t handler,
                                                         const std::string& name) {
  external_func_t func = GetProcAddress(handler, name.c_str());
  if (!func) {
    throw_error_message(Error::EXT_LIBRARY, name);
  }
  return func;
}

/**
 * Close handler of library for windows environment.
 * @param Hander of library that has loaded.
 */
void DynamicLibrary::close_lib(DynamicLibrary::lib_handler_t handler) {
  FreeLibrary(handler);
}

#else  // not _WIN32

/**
 * Open library by dynamic loading for Android, Linux, OSX, Unix.
 * @param fname Filename for loading.
 * @return Handler of library.
 */
DynamicLibrary::lib_handler_t DynamicLibrary::open_lib(const std::string& fname) {
  lib_handler_t lib = dlopen(fname.c_str(), RTLD_LAZY);
  if (!lib) {
    throw_error_message(Error::EXT_LIBRARY, dlerror());
  }
  return lib;
}

/**
 * Get the function by a loading library for Android, Linux, OSX, Unix.
 * @param handler Handler of library.
 * @param name Function symbol name.
 * @return Pointer to function that has loaded.
 */
DynamicLibrary::external_func_t DynamicLibrary::get_func(lib_handler_t handler,
                                                         const std::string& name) {
  external_func_t func;

  if (handler == nullptr) {
    func = reinterpret_cast<external_func_t>(dlsym(RTLD_DEFAULT, name.c_str()));
  } else {
    func = reinterpret_cast<external_func_t>(dlsym(handler, name.c_str()));
  }

  if (!func) {
    throw_error_message(Error::EXT_LIBRARY, dlerror());
  }
  return func;
}

/**
 * Close handler of library for Android, Linux, OSX, Unix.
 * @param Hander of library that has loaded.
 */
void DynamicLibrary::close_lib(DynamicLibrary::lib_handler_t handler) {
  dlclose(handler);
}

#endif  // endif without _WIN32
}  // namespace processwarp
#endif  // EMSCRIPTEN
