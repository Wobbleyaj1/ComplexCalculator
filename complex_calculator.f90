! A Fortran program that performs basic arithmetic operations on complex numbers
program complexCalculator

    implicit none

    ! Define a complex number type
    type complex_number
        real(kind=8) :: real, imag
    end type complex_number

    ! Type declarations
    type(complex_number) :: var1, var2, result
    real(kind=8) :: var1_real, var1_imag, var2_real, var2_imag

    ! Executable statements
    var1_real = 10.0
    var1_imag = 2.0
    var2_real = 8.0
    var2_imag = 4.0
    var1 = make_complex(var1_real, var1_imag)
    var2 = make_complex(var2_real, var2_imag)
    result = add(var1, var2)
    print *, 'The total is ', result

contains

    ! constructor: build a complex_number from real and imag parts
    function make_complex(re, im) result(c)

        implicit none

        ! local variables
        type(complex_number) :: c
        real(kind=8) :: re, im

        ! assign parts
        c%real = re
        c%imag = im

    end function make_complex

    ! this function adds two complex numbers var1 and var2.
    function add (var1, var2) result(sum)

        implicit none

        ! local variables 
        type(complex_number) :: var1, var2, sum
        real(kind=8) :: sum_real, sum_imag

        ! real part
        sum_real = var1%real + var2%real

        ! imag part
        sum_imag = var1%imag + var2%imag

        ! combine parts
        sum = make_complex(sum_real, sum_imag)
    
    end function add

    ! subtracts complex number var2 from var1.
    function subtract (var1, var2) result(difference)

        implicit none

        ! local variables 
        type(complex_number) :: var1, var2, difference
        real(kind=8) :: difference_real, difference_imag

        ! real part
        difference_real = var1%real - var2%real

        ! imag part
        difference_imag = var1%imag - var2%imag

        ! combine parts
        difference = make_complex(difference_real, difference_imag)

    end function subtract

    ! multiplies two complex numbers var1 and var2.
    function multiply (var1, var2) result(product)
        
        implicit none

        ! local variables 
        type(complex_number) :: var1, var2, product
        real(kind=8) :: product_real, product_imag

        ! real part: (var1%real * var2%real) - (var1%imag * var2%imag)
        product_real = (var1%real * var2%real) - (var1%imag * var2%imag)

        ! imag part: (var1%real * var2%imag) + (var1%imag * var2%real)
        product_imag = (var1%real * var2%imag) + (var1%imag * var2%real)

        ! combine parts
        product = make_complex(product_real, product_imag)

    end function multiply

    ! divides complex number var1 by var2.
    function divide (var1, var2) result(quotient)

        implicit none

        ! local variables
        type(complex_number) :: var1, var2, quotient
        real(kind=8) :: quotient_real, quotient_imag, denominator

        ! denominator: (var2%real)^2 + (var2%imag)^2
        denominator = ((var2%real)**2 + (var2%imag)**2)

        ! real part: ((var1%real * var2%real) + (var1%imag * var2%imag)) / denominator
        quotient_real = ((var1%real * var2%real) + (var1%imag * var2%imag)) / denominator

        ! imag part: ((var1%imag * var2%real) - (var1%real * var2%imag)) / denominator
        quotient_imag = ((var1%imag * var2%real) - (var1%real * var2%imag)) / denominator

        ! combine parts
        quotient = make_complex(quotient_real, quotient_imag)
        
    end function divide

    ! raises complex number var1 to the power of integer n.
    function power (var1, n) result(result)

        implicit none

        ! local variables
        type(complex_number) :: var1, result, temp
        integer :: n, i

        ! initialize result to 1 + 0i
        result = make_complex(1.0d0, 0.0d0)
        temp = var1

        ! loop to multiply var1 n times
        do i = 1, n
            result = multiply(result, temp)
        end do

    end function power

    ! returns the complex conjugate of a complex number var1.
    function conjugate(var1) 

        implicit none

        ! local variables
        type(complex_number) :: var1, conjugate
        real(kind=8) :: conj_real, conj_imag

        ! real part remains the same
        conj_real = var1%real

        ! imag part is negated
        conj_imag = -var1%imag
        
        ! combine parts
        conjugate = make_complex(conj_real, conj_imag)

    end function conjugate

end program complexCalculator

