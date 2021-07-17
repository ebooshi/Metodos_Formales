Práctica 2: Framma - C

Muñoz Barón Luis Miguel

Métodos Formales Facultad de Ciencias, Universidad Nacional Autónoma de México 2021-2

Ejercicios:

1._ Corrección de SelectionSort E InsertionSort
Tiempo: 45 minutos aproximadamente viendo videos del algoritmo y 
leyendo la implementación para buscar los errores así como definir
funciones para debuggear los algoritmos y ver la información que
contienen.

¿Consideras que tu implementación es formalmente correcta?

Sí, una vez entendiendo la lógica del algoritmo es fácil implementarlo.

InsertionSort va extendiendo el prefijo ordenado del arreglo recorriendo 
los elementos que ya están bien una posición a la derecha hasta encontrar
un hueco para insertar el nuevo elemento y extender el prefijo ordenado 
una unidad por iteración. En particular cuando llegamos a la n-ésima
iteración donde n es el tamaño del arreglo habremos ordenado el prefijo
de la entrada que consta de n elementos, es decir el arreglo en su 
totalidad.

Para selectionSort la idea es similar, vamos buscando el elemento más pequeño
pero ahora por posición del arrreglo y lo recorremos desde el último indice
del prefijo que ya tenemos ordenado hasta la n-ésima posición donde n es 
el tamaño de la entrada, al hacer ésto n veces habremos insertado correctamente
en las n posiciones del arreglo el elemento que debe de estar para que se cumpla
la propiedad de ser un arreglo ordenado.

Por lo tanto ambas implementaciones son correctas en el sentido de que cumplen
con la propiedad de regresar un arreglo tal que

"para todo número entero i con 0 <= i < n se cumple que: arr[i] <= arr[i+1] ".

3. mide tu tiempo en realizar esta tarea
aproximadamente 30 minutos.

5. Compara los tiempos de reparación y brinda una conclusión de haber reparado el código a
conocimiento tuyo en comparación con los mensajes proporcionados por Frama-C.

Utilizar una herramienta como Framma C es útil en el sentido de que guía la depuración
facilita cazar errores de dedo, condiciones pobremente implementadas y logística general
del algoritmo, Mientras que depurar a mano puede ser una moneda de dos caras, si estás 
cansado o simplemente muy atorado con un algoritmo depurar te va a llevar mucho tiempo 
porque no se tiene un camino definido de qué hacer y tienes que utilizar tu ingenio
para darle la vuelta a los problemas como utilizar prints o carteles.


Referencias:

[1] https://www.geeksforgeeks.org/selection-sort/
[2] http://akira.ruc.dk/~keld/teaching/CAN_e14/Readings/How%20to%20Compile%20and%20Run%20a%20C%20Program%20on%20Ubuntu%20Linux.pdf
[3] https://www.geeksforgeeks.org/insertion-sort/
[5] https://www.youtube.com/watch?v=OGzPmgsI-pQ
[6] https://www.youtube.com/watch?v=xWBP4lzkoyM&ab_channel=GeeksforGeeks
[7] https://git.frama-c.com/pub/frama-c/blob/master/INSTALL.md