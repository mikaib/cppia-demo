package my_extern;

@:buildXml('<include name="${haxelib:cppia_demo}/Build.xml" />') // usually one should probably use a build macro to avoid hardcoding paths
@:include('extern_demo.hpp')
@:unreflective
private extern class _MyExtern {
    @:native('demo_sum_of_int_list')
    public static function _sum_of_int_list(arr: cpp.Pointer<cpp.Int32>, len: cpp.Int32): cpp.Int32;

    @:native('demo_sum_of_two_ints')
    public static function _sum_of_two_ints(pair: TwoInts): cpp.Int32;

    @:native('demo_squared')
    public static function _squared(x: cpp.Int32): cpp.Int32;
}

class MyExtern {

    public static #if (!DEMO_STUB) inline #end function squared(x: Int): Int {
        return _MyExtern._squared(x);
    }

    public static #if (!DEMO_STUB) inline #end function sum_of_int_list(arr: Array<Int>): Int {
        return _MyExtern._sum_of_int_list(
            cpp.Pointer.arrayElem(arr, 0).reinterpret(),
            arr.length
        );
    }

    public static #if (!DEMO_STUB) inline #end function sum_of_two_ints(pair: TwoInts): Int {
        return _MyExtern._sum_of_two_ints(pair);
    }

}