module formatter_module
    use types_module, only: complex_number
    implicit none

contains

    function format_complex(c, format_option) result(str)
        type(complex_number), intent(in) :: c
        integer, intent(in) :: format_option
        character(len=100) :: str
        character(len=50) :: re_str, im_str

        if (format_option == 1) then
            write (re_str, '(F10.4)') c%real
            write (im_str, '(F10.4)') c%imag
            str = '(' // trim(adjustl(re_str)) // ',' // trim(adjustl(im_str)) // ')'
        else if (format_option == 2) then
            write (re_str, '(F10.4)') c%real
            write (im_str, '(F10.4)') abs(c%imag)
            if (c%imag >= 0.0d0) then
                str = trim(adjustl(re_str)) // '+' // trim(adjustl(im_str)) // '*i'
            else
                str = trim(adjustl(re_str)) // '-' // trim(adjustl(im_str)) // '*i'
            end if
        else
            write (re_str, '(F10.4)') c%real
            write (im_str, '(F10.4)') c%imag
            str = '(' // trim(adjustl(re_str)) // ',' // trim(adjustl(im_str)) // ')'
        end if
    end function format_complex

end module formatter_module
