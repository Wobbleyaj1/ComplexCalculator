module parser_module
    
    use types_module, only: complex_number

    implicit none

contains

    ! parse complex number from string input in three formats:
    function parse_complex(input_str) result(c)
        
        implicit none

        ! local variables
        character(len=*) :: input_str
        type(complex_number) :: c
        integer :: paren_open, paren_close, i_pos
        character(len=100) :: str_trimmed

        str_trimmed = adjustl(input_str)

        ! format 1: (real,imag)
        paren_open = index(str_trimmed, '(')
        paren_close = index(str_trimmed, ')')
        if (paren_open > 0 .and. paren_close > paren_open) then
            call parse_parentheses_format(str_trimmed(paren_open+1:paren_close-1), c)
            return
        end if

        ! format 2: real+imag*i or real-imag*i
        i_pos = index(str_trimmed, '*i')
        if (i_pos > 0) then
            call parse_exponential_format(str_trimmed, c)
            return
        end if

        ! format 3: real number only
        call parse_real_format(str_trimmed, c)

    end function parse_complex

    ! parse format: (real,imag)
    subroutine parse_parentheses_format(str, c)
        implicit none
        character(len=*) :: str
        type(complex_number) :: c
        integer :: comma_pos, stat
        character(len=50) :: re_str, im_str
        real(kind=8) :: re, im

        comma_pos = index(str, ',')
        if (comma_pos > 0) then
            re_str = adjustl(str(1:comma_pos-1))
            im_str = adjustl(str(comma_pos+1:))
            read (re_str, *, iostat=stat) re
            if (stat /= 0) re = 0.0d0
            read (im_str, *, iostat=stat) im
            if (stat /= 0) im = 0.0d0
            c = complex_number(re, im)
        else
            c = complex_number(0.0d0, 0.0d0)
        end if
    end subroutine parse_parentheses_format

    ! parse format: real+imag*i or real-imag*i
    subroutine parse_exponential_format(str, c)
        implicit none
        character(len=*) :: str
        type(complex_number) :: c
        integer :: i_pos, plus_pos, minus_pos, j, stat
        character(len=100) :: work_str
        character(len=50) :: re_str, im_str
        real(kind=8) :: re, im
        logical :: found_op

        work_str = adjustl(str)
        i_pos = index(work_str, '*i')
        re = 0.0d0
        im = 0.0d0

        ! Find the last + or - before *i
        found_op = .false.
        plus_pos = 0
        minus_pos = 0

        ! Search for + or - that separates real and imaginary parts
        do j = i_pos - 1, 2, -1
            if (work_str(j:j) == '+') then
                plus_pos = j
                found_op = .true.
                exit
            else if (work_str(j:j) == '-') then
                minus_pos = j
                found_op = .true.
                exit
            end if
        end do

        if (.not. found_op) then
            ! No real part, just imaginary
            im_str = adjustl(work_str(1:i_pos-1))
            read (im_str, *, iostat=stat) im
            if (stat /= 0) im = 0.0d0
        else if (plus_pos > 0) then
            re_str = adjustl(work_str(1:plus_pos-1))
            im_str = adjustl(work_str(plus_pos+1:i_pos-1))
            read (re_str, *, iostat=stat) re
            if (stat /= 0) re = 0.0d0
            read (im_str, *, iostat=stat) im
            if (stat /= 0) im = 0.0d0
        else if (minus_pos > 0) then
            re_str = adjustl(work_str(1:minus_pos-1))
            im_str = adjustl(work_str(minus_pos+1:i_pos-1))
            read (re_str, *, iostat=stat) re
            if (stat /= 0) re = 0.0d0
            read (im_str, *, iostat=stat) im
            if (stat /= 0) im = 0.0d0
            im = -im
        end if

        c = complex_number(re, im)
    end subroutine parse_exponential_format

    ! Parse format: real number only
    subroutine parse_real_format(str, c)
        implicit none
        character(len=*) :: str
        type(complex_number) :: c
        integer :: stat
        real(kind=8) :: re

        read (str, *, iostat=stat) re
        if (stat == 0) then
            c = complex_number(re, 0.0d0)
        else
            c = complex_number(0.0d0, 0.0d0)
        end if
    end subroutine parse_real_format

end module parser_module
