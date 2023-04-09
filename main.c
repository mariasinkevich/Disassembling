#include <stdio.h>
#include <conio.h>

int main() {
    int a[5], a256[5];
    size_t i;
    printf("Please, enter 5 unsigned decimal numbers from 0 to 255 inclusively: \n");
    for(i=0; i<5; i++) {
        scanf("%hhu", &a[i]); }
    printf("\n\nEntered numbers (decimal):\n");
    for(i=0; i<5; i++) {
        a256[i]=a[i]%256; }
    for(i=0; i<5; i++)
        printf("%d ", a256[i]);
    for(i=0; i<5; i++) {
        a256[i]=(a256[i]^0x4D) & (0x5A+i); }
    printf("\n\nResult (decimal):\n");
    for(i=0; i<5; i++) {
        printf("%d ", a256[i]); }
    printf("\n\nPress any key...\n");
    getch();
return 0;
}
