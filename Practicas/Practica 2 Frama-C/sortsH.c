 #include <stdio.h>


/*@ requires \valid(x) && \valid(y);
 *  ensures \let oldX = \old(*x) ; 
 *	        \let oldY = \old(*y) ; *x == oldY && *y == oldX;
 */
void swap(int *xp, int *yp)
{
    int temp = *xp;
    *xp = *yp;
    *yp = temp;
}
 
/*
*   @requires \valid(arr+(0..n-1)) && n >= 0;
*   @ensures \forall integer i; 1 <= i <= n-1 => \at(arr[i],Here) <= \at(arr[i+1],Here);
*/
void selectionSort(int arr[], int n)
{
	int i, j, min_idx;
	for (i = 0; i < n-1; i++)
	{
		min_idx = i;
		for (j = i+1; j < n; j++){
			if (arr[j] < arr[min_idx]){
				min_idx = j;
			}
            /*
             * @loop invariant \forall integer x; j <= x < n => min_idx <= \at(arr[x],Here)
             */
		}
		swap(&arr[i], &arr[min_idx]);
        /*
         * @loop invariant \forall integer y; 0 <= y < i => \at(arr[y],Here) <= \at(arr[y+1],Here);
         */
	}
}


/*
 *   @requires \valid(arr+(0..n-1)) && n >= 0;
 *   @ensures 
 *           \forall integer i; 1 <= i <= n-1 => \at(arr[i],Here) <= \at(arr[i+1],Here);
 */
void insertionSort(int arr[], int n)
{
    int i, key, j;
    for (i = 1; i < n; i++) { 
        key = arr[i];
        j = i - 1; 
        while (j >= 0 && arr[j] >= key) {
            arr[j + 1] = arr[j];
            j = j - 1;
        }
        /*
         * @loop invariant 
         *     \forall integer x; j <= x < i => \at(arr[x],old) = \at(arr[x+1],Here)
         */
        arr[j+1] = key;
        /*
         * @loop invariant 
         *      \forall integer y; 0 <= y < i => \at(arr[y],Here) <= \at(arr[y+1],Here);
         */
    }
}

void printArray(int arr[], int size)
{
    int i;
    for (i=0; i < size; i++)
        printf("%d ", arr[i]);
    printf("\n");
}
 

int main()
{
	int arr[] = {64, 25, 12, 22, 11};
	int n = sizeof(arr)/sizeof(arr[0]);
	selectionSort(arr, n-2);
	int arr2[] = {64, 25, 12, 22, 11};
	int n2 = sizeof(arr2)/sizeof(arr[0]);
	insertionSort(arr2, n2-10);
    printArray(arr, n);
    printArray(arr2, n2);
	return 0;
}