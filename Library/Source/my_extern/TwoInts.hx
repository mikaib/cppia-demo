package my_extern;

@:buildXml('<include name="${haxelib:cppia_demo}/Build.xml" />') // usually one should probably use a build macro to avoid hardcoding paths
@:include('extern_demo.hpp')
@:native('demo_two_ints')
@:structAccess
@:unreflective
private extern class _NativeTwoInts {
    public var a: cpp.Int32;
    public var b: cpp.Int32;

    @:native("new demo_two_ints")
    public static function make(): cpp.Pointer<_NativeTwoInts>;

    @:native("log_values")
    public function log_values(): Void;
}

abstract TwoInts(cpp.Pointer<_NativeTwoInts>) {
    public var a(get, set): Int;
    #if (!DEMO_STUB) inline #end function get_a(): Int return this.ptr.a;
    #if (!DEMO_STUB) inline #end function set_a(value: Int): Int return this.ptr.a = value;

    public var b(get, set): Int;
    #if (!DEMO_STUB) inline #end function get_b(): Int return this.ptr.b;
    #if (!DEMO_STUB) inline #end function set_b(value: Int): Int return this.ptr.b = value;

    public #if (!DEMO_STUB) inline #end function new(a: Int, b: Int) {
        this = _NativeTwoInts.make();
        abstract.a = a;
        abstract.b = b;
    }

    public #if (!DEMO_STUB) inline #end function log_values(): Void {
        this.ptr.log_values();
    }

    public #if (!DEMO_STUB) inline #end function destroy(): Void {
        this.destroy();
    }
}