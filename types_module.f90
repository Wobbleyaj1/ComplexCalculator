module types_module
    
    implicit none

    ! Define a complex number type
    type, public :: complex_number
        real(kind=8) :: real, imag
    end type complex_number

end module types_module
