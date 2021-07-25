/*
 *@ requires \valid(*x) && \valid(*y);
 *@ ensures  \let oldX = \old(*x) ; 
 *@          \let oldY = \old(*y) ;
 *@          oldX == \at(*y,Here) && oldY == \at(*x,Here);
*/
void swap(int *x,int *y){
    int temp = *x;
    *x = *y;
    *y = temp;
}
 
 
/*
*   @requires \valid(arr+(0..n-1)) && n >= 0;
*   @ensures  \forall integer i; 0 <= i < n => \at(arr[i],Here) <= \at(arr[i+1],Here);
*/
void selectionSort(int arr[], int n)
{
    /*
     * @loop invariant \forall integer y; 1 <= y < i => \at(arr[y],Here) <= \at(arr[y+1],Here);
     */    
	int i, j, min_idx;
	for (i = 0; i < n-1; i++)
	{
        /*
         * @loop invariant \forall integer x; i <= x <= j => min_idx <= \at(arr[x],Here)
         */        
		min_idx = i;
		for (j = i+1; j < n; j++){
			if (arr[j] < arr[min_idx]){
				min_idx = j;
			}
		}
		swap(&arr[i], &arr[min_idx]);
	}
}


/*
 *   @requires \valid(arr+(0..n-1)) && n >= 0;
 *   @ensures  \forall integer i; 1 <= i < n => \at(arr[i],Here) <= \at(arr[i+1],Here);
 */
void insertionSort(int arr[], int n)
{
    /*
     * @loop invariant \forall integer y; 0 <= y < i => \at(arr[y],Here) <= \at(arr[y+1],Here);
     */    
    int i, key, j;
    for (i = 1; i < n; i++) { 
        /*
         * @loop invariant \forall integer x; j <= x < i => \at(arr[x],old) = \at(arr[x+1],Here)
         */
        key = arr[i];
        j = i - 1; 
        while (j >= 0 && arr[j] >= key) {
            arr[j + 1] = arr[j];
            j = j - 1;
        }
        arr[j+1] = key;
    }
}
 
int main()
{
	int arr[] = {64, 25, 12, 22, 11};
	int n = sizeof(arr)/sizeof(arr[0]);
	selectionSort(arr, n);
	int arr2[] = {64, 25, 12, 22, 11};
	int n2 = sizeof(arr2)/sizeof(arr2[0]);
	insertionSort(arr2, n2);
	/*
	*  @ assert \forall integer i; 0 <= i < n => \at(arr[i],Here) = \at(arr2[i],Here);
	*/
	return 0;
}
