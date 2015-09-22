
#include "std_error.hpp"

namespace processwarp {

// Constractor with errno.
StdError::StdError(vm_int_t std_errno_) :
    std_errno(std_errno_) {
}
}  // namespace processwarp
