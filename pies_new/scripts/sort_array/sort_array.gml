///@desc Returns a sorted version of a given array
///@arg array
///@arg ascending
function sort_array(id, _ascending) {
	//
	// array_sort(array, ascend)
	//      array        array to sort, array
	//      ascend       ascending (true) or descending (false) order, boolean
	//
	/// GMLscripts.com/license
	{
	    var array = id;
	    var ascend = _ascending;
	    var list = ds_list_create();
	    var count = array_length(array);
	    for (var i=0; i<count; i++) list[| i] = array[i];
	    ds_list_sort(list, ascend);
	    for (i=0; i<count; i++) array[i] = list[| i];
	    ds_list_destroy(list);
	    return array;
	}


}
