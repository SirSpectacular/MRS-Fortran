#if !defined(P)
#define P 4
#endif

module gauss_mod
    implicit none

contains
    subroutine gauss_elimination (A, X, N)
        implicit none
        integer (kind = 8), intent(in)  :: N
        real (kind = P), intent(inout)  :: A(N, N), X(N)
        integer (kind = 8)              :: i, j
        real (kind = P)                 :: C

        do i = 1, N
            do j = 1, N
                if (i .NE. j) then
                    C = A(i, j) / A(i, i)
			        A(:, j) = A(:, j) - C * A(:, i)
			        X(j) = X(j) - C * X(i)
                    X(i) = X(i) / A (i, i)
			        A(:, i) = A(:, i) / A(i, i)
                endif
            enddo
        enddo
    endsubroutine gauss_elimination
endmodule gauss_mod