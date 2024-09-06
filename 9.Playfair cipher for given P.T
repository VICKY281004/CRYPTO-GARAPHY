#include <stdio.h>
#include <string.h>
#include <ctype.h>

#define SIZE 5

// Function to prepare the Playfair matrix
void generatePlayfairMatrix(char key[], char matrix[SIZE][SIZE]) {
    int used[26] = {0};
    int i, j, k = 0, row = 0, col = 0;

    // Populate matrix with the key
    for (i = 0; key[i] != '\0'; i++) {
        char c = tolower(key[i]);
        if (c == 'j') c = 'i'; // J is treated as I
        if (!used[c - 'a']) {
            matrix[row][col++] = c;
            used[c - 'a'] = 1;
            if (col == SIZE) {
                col = 0;
                row++;
            }
        }
    }

    // Fill remaining letters of the alphabet
    for (i = 0; i < 26; i++) {
        if (i + 'a' == 'j') continue; // J is treated as I
        if (!used[i]) {
            matrix[row][col++] = i + 'a';
            if (col == SIZE) {
                col = 0;
                row++;
            }
        }
    }
}

// Function to print the Playfair matrix
void printMatrix(char matrix[SIZE][SIZE]) {
    for (int i = 0; i < SIZE; i++) {
        for (int j = 0; j < SIZE; j++) {
            printf("%c ", matrix[i][j]);
        }
        printf("\n");
    }
}

// Playfair cipher encryption
void encryptPlayfair(char matrix[SIZE][SIZE], char message[]) {
    int len = strlen(message);

    for (int i = 0; i < len - 1; i += 2) {
        char a = message[i];
        char b = message[i + 1];

        // Find positions of both characters
        int rowA, colA, rowB, colB;
        for (int row = 0; row < SIZE; row++) {
            for (int col = 0; col < SIZE; col++) {
                if (matrix[row][col] == a) {
                    rowA = row;
                    colA = col;
                }
                if (matrix[row][col] == b) {
                    rowB = row;
                    colB = col;
                }
            }
        }

        // Same row
        if (rowA == rowB) {
            printf("%c%c ", matrix[rowA][(colA + 1) % SIZE], matrix[rowB][(colB + 1) % SIZE]);
        }
        // Same column
        else if (colA == colB) {
            printf("%c%c ", matrix[(rowA + 1) % SIZE][colA], matrix[(rowB + 1) % SIZE][colB]);
        }
        // Rectangle swap
        else {
            printf("%c%c ", matrix[rowA][colB], matrix[rowB][colA]);
        }
    }
}

int main() {
    char matrix[SIZE][SIZE];
    char key[] = "MFHIKUNOPQZVWXEALGDRSTBC";  // Provided Playfair key matrix in string form
    char message[] = "mustseeyouovercadoganwestcomingatonce";

    generatePlayfairMatrix(key, matrix);
    printf("Playfair Matrix:\n");
    printMatrix(matrix);

    printf("\nEncrypted Message: ");
    encryptPlayfair(matrix, message);

    return 0;
}
