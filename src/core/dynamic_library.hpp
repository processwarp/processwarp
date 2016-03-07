#pragma once

#if defined(_WIN32)
#include <windows.h>
#elif !defined(EMSCRIPTEN)
#include <dlfcn.h>
#endif

#include <string>

#ifndef EMSCRIPTEN
namespace processwarp {
namespace DynamicLibrary {

/** Type for dynamic link library handler. */
#ifdef _WIN32
typedef HMODULE lib_handler_t;
#else
typedef void* lib_handler_t;
#endif
/** Type for external function pointer. */
typedef void (*external_func_t)();

lib_handler_t open_lib(const std::string& fname);
external_func_t get_func(lib_handler_t handler, const std::string& name);
void close_lib(lib_handler_t handler);

}  // namespace DynamicLibrary
}  // namespace processwarp
#endif
