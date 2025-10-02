# extern requirements / suggestions
- the host *must* be compiled with `-D scriptable`
- the host *must* export a file of the symbols that it includes using `-D dll_export=export_classes.info`
- the host *must* stub all calls to externs through a haxe function if needed by the module (don't allow the module to directly call externs!)
- the host *must* ensure it includes all externs and stubs using `--macro include("my_package")`
- the host *must* ensure that functions don't get DCE'd using `-dce no`
- the host *should* bypass the stubbed functions whenever possible to avoid overhead, a few strategies from the top of my head:
  - inlining the stubs if `scriptable` or `cppia` is not set.
  - using a typedef to refer to the externs directly if `scriptable` or `cppia` is not set
  - using a 2nd stub layer which is fully inlined and calls the stubs if `cppia` is set and otherwise calls the extern directly, this allows you to always avoid the overhead on the host even if cppia is used.
- the module *must* not use any types that are relevant to C++ syntax (like `cpp.Star<T>` or `cpp.RawPointer<T>`), but haxe-ified types like `cpp.Pointer<T>` are OK.
- the module *must* import the file of symbols using `-D dll_import=export_classes.info`
- the module *must* only call functions or use variables which support `Dynamic`

# what this demo shows
- How to call a native function.
- How to extern a class, construct it, access variables and functions and destroy it.
- How to pass extern classes to a function.
- How to pass arrays of primitive types to a function.
- How to make all of this compatible with cppia.

# running
- first use ``haxelib dev cppia_demo ./Library``
- then use ``haxe Host.hxml`` to build the host
- then use ``haxe Module.hxml`` to build the module
- now run the host at ``./Binary/HostMain.exe``

# expected output
```
Host/HostMain.hx:10: ------ FROM HOST ------
a: 50, b: 50
squared(5) = 25
sum_of_int_list([1, 2, 3, 4]) = 10
sum_of_two_ints(my_extern.TwoInts(25, 25)) = 50
sum_of_two_ints(my_extern.TwoInts(50, 50)) = 100

Module/ModuleMain.hx:8: ------ FROM MODULE ------
a: 50, b: 50
squared(5) = 25
sum_of_int_list([1, 2, 3, 4]) = 10
sum_of_two_ints(my_extern.TwoInts(25, 25)) = 50
sum_of_two_ints(my_extern.TwoInts(50, 50)) = 100
```