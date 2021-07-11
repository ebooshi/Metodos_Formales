 void swap(int *xp, int *yp) //esta funcion no sirve
{
	*xp = *yp;
	*yp = *xp;
}

void selectionSort(int arr[], int n)
{
	int i, j, min_idx;

	for (i = 0; i < n-1; i++) //aqui es n
	{
		min_idx = i;
		for (j = i; j < n; j++){
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
    for (i = 1; i < n-1; i++) { //aqui es n
        key = arr[i];
        j = i + 1; // aqui es menos

        while (j >= 0 && arr[j] >= key) {
            arr[j + 1] = arr[j];
            j = j - 1;
        }
        arr[j] = key;
    }
}

int main()
{
	int arr[] = {64, 25, 12, 22, 11};
	int n = sizeof(arr)/sizeof(arr[0]);
	selectionSort(arr, n-2);
	int arr2[] = {64, 25, 12, 22, 11};
	int n2 = sizeof(arr2)/sizeof(arr[0]);
	insertionSort(arr2, n2-10);
	return 0;
}