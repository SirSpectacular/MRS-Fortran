#if !defined(P)
#define P 4
#endif

program main
    use gauss_mod
    use str2int_mod
    implicit none

    logical                         :: exist
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
        P1 = -1 / (h ** 2)
        P2 = 2 / (h ** 2)
        P3 = -1 / (h ** 2)
    
    

        !init variables
        A(:, :) = 0
        X(:) = 0
        X(N) = 1
        error = 0
    

        !fill matrix
        do i = 1, N
            if (i .NE. N) then
                A(i, i + 1) = P1
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
        inquire(file="out.txt", exist=exist)
        if(exist) then
            open(7, file="out.txt", status="old", position="append", action="write")
        else
            open(7, file="out.txt", status="new", action="write")
        end if

        write(7, *) error / N
        write(7, *) X

        deallocate(A)
        deallocate(X)
    else
        print *,'Conversion of string ',input_buffer,' failed!'
    endif

end program main