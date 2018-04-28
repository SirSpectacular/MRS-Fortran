#if !defined(P)
#define P 4
#endif

program main
    use gauss_mod
    use str2int_mod
    implicit none

    character(32)                   :: input_buffer
    integer (kind = 8)              :: i, N, stat
    real (kind = P), allocatable    :: A(:, :), X(:)
    real (kind = P)                 :: h, P1, P2, P3
    real (kind = 16)                :: error

    call get_command_argument(1, input_buffer)
    call str2int(input_buffer, N, stat)
    if (stat .EQ. 0) then

        allocate(A(N, N))
        allocate(X(N))
        h = 1. / N
        P1 = 1 / (h * h)
        P2 = -2 / (h * h)
        P3 = 1 / (h * h)
    
    

        !init variables
        A(:, :) = 0.d0
        X(:) = 0.d0
        X(N) = 1.d0
        error = 0.d0
    

        !fill matrix
        do i = 1, N
            if (i .NE. N) then
                A(i, i+1) = P1
            endif

            A(i, i) = P2

            if (i .NE. 1) then
                A(i, i - 1) = P3
            endif
        enddo
        
        !eliminate
        call gauss_elimination(A, X, N)

        !sum errors 
        do i = 1, N
            error = error + abs(X(i) - real(i) / real(N))
        end do

        !put data
        write(*, *) error / N
        write(*, *) X

        deallocate(A)
        deallocate(X)
    else
        print *,'Conversion of string ',input_buffer,' failed!'
    endif

end program main