#pragma once

#include <functional>
#include <map>

namespace processwarp {
  /**
   * It provide trigger for finalize function by useing RAII.
   */
  class Finally {
  public:
    /**
     * Constructor.
     */
    Finally();

    /**
     * Kick finalize functions in destructor.
     * Functions are called reverse order by added.
     */
    virtual ~Finally();
    
    /**
     * Add a finalize function.
     * Finalize function must not throw exception.
     * @param func A finalize function.
     * @return A assigned key for function.
     */
    int add(std::function<void()> func);

    /**
     * Remove finalize function.
     * Do noting if key is 0.
     * @param key A assigned key for function.
     */
    void remove(int key);
    
  private:
    /** Next assign key. */
    int next_key;
    /** Map of assign keys and functions. */
    std::map<int, std::function<void()>> funcs;
  };
}
