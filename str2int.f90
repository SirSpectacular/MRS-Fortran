module str2int_mod
    contains 
    
      elemental subroutine str2int(str,int,stat)
        implicit none
        ! Arguments
        character(len=*),intent(in)  :: str
        integer(kind=8), intent(out) :: int, stat
    
        read(str,*,iostat=stat)  int
      endsubroutine str2int 
endmodule str2int_mod