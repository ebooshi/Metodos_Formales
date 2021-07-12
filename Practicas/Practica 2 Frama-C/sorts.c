 #include <stdio.h>

void swap(int *xp, int *yp)
{
    int temp = *xp;
    *xp = *yp;
    *yp = temp;
}
 

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
		}

		swap(&arr[i], &arr[min_idx]);
	}
}

void insertionSort(int arr[], int n)
{
    int i, key, j;
    for (i = 1; i < n; i++) { //aqui es n
        key = arr[i];
        j = i - 1; // aqui es menos

        while (j >= 0 && arr[j] >= key) {
            arr[j + 1] = arr[j];
            j = j - 1;
        }
        arr[j+1] = key;
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