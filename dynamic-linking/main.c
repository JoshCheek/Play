#include <stdio.h>
#include <dlfcn.h>

int main() {
  void *hw = dlopen("/Users/joshcheek/deleteme/dynamic_linking/hw.so", RTLD_NOW);
  void (*hello_world)();
  hello_world = dlsym(hw, "say_hello");
  hello_world();
  dlclose(hw);
}
