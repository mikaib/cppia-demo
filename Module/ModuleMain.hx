import my_extern.MyExtern;
import my_extern.TwoInts;

class ModuleMain {

    public static function main(): Void {
        // log origin
        trace("------ FROM MODULE ------");

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

}