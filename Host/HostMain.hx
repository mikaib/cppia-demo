import my_extern.MyExtern;
import my_extern.TwoInts;
import cpp.cppia.Host;
import haxe.io.Path;
import sys.FileSystem;

class HostMain {

    public static function test(): Void {
        // log origin
        trace("------ FROM HOST ------");

        // example : basic function call
        var sq = MyExtern.squared(5);

        // example : Array<Int> to int*
        var list = [1, 2, 3, 4];
        var listSum = MyExtern.sum_of_int_list(list);

        // example : C++ Class <-> Haxe class
        var pair = new TwoInts(25, 25);
        var pairSumA = MyExtern.sum_of_two_ints(pair);

        pair.a += 25;
        pair.b = 50;
        var pairSumB = MyExtern.sum_of_two_ints(pair);

        pair.log_values();
        pair.destroy();

        // log results
        Sys.println('squared(5) = $sq');
        Sys.println('sum_of_int_list([1, 2, 3, 4]) = $listSum');
        Sys.println('sum_of_two_ints(my_extern.TwoInts(25, 25)) = $pairSumA');
        Sys.println('sum_of_two_ints(my_extern.TwoInts(50, 50)) = $pairSumB');
    }

    public static function main(): Void {
        test();

        var root = Path.directory(Sys.programPath());
        var classPath = Path.join([ root, "..", "Module", "ModuleMain.hx" ]);
        var modulePath = Path.join([ root, "output.cppia" ]);
        var last = -1.0;

        while (true) {
            var stat = FileSystem.stat(classPath);
            var mtime = stat.mtime.getTime();

            if (mtime != last) {
                Sys.command('haxe Module.hxml');
                Host.runFile(modulePath);
                Sys.println("------ Please make changes to ModuleMain.hx to see them here, or press Ctrl-C to exit ------");
                last = mtime;
            }

            Sys.sleep(1);
        }
    }

}