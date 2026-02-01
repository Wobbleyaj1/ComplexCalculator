! A Fortran program that performs basic arithmetic operations on complex numbers
program complexCalculator

    use types_module, only: complex_number
    use parser_module, only: parse_complex
    use formatter_module, only: format_complex
    use operations_module, only: add, subtract, multiply, divide, power, conjugate

    implicit none

    ! Type declarations
    type(complex_number) :: var1, var2, result
    character(len=100) :: input1, input2, op_choice, format_choice, continue_choice, exponent_str
    integer :: op_code, format_option, exponent
    logical :: keep_running

    ! Executable statements
    keep_running = .true.

    ! Display format information at the start
    write (*, *) ''
    write (*, *) '===== Complex Number Calculator ====='
    write (*, *) ''
    write (*, *) 'Supported Formats for Complex Numbers:'
    write (*, *) '  (real,imag)    e.g., (3.0,4.0)'
    write (*, *) '  real+imag*i    e.g., 3.0+4.0*i'
    write (*, *) '  real           e.g., 5.0'

    do while (keep_running)

        op_code = 0

        ! Display operation menu first
        write (*, *) ''
        write (*, *) 'Select operation:'
        write (*, *) '  1. Addition (+)'
        write (*, *) '  2. Subtraction (-)'
        write (*, *) '  3. Multiplication (*)'
        write (*, *) '  4. Division (/)'
        write (*, *) '  5. Power (^)'
        write (*, *) '  6. Conjugate (conj)'
        write (*, *) ''
        
        ! Keep asking for operation until valid
        do while (op_code < 1 .or. op_code > 6)

            write (*,'(A)', advance='no') 'Enter operation (1-6): '
            read (*, '(A)') op_choice
            read (op_choice, *, iostat=op_code) op_code
            if (op_code < 1 .or. op_code > 6) then

                write (*, *) 'Invalid operation. Please enter a number between 1 and 6.'
                op_code = 0

            end if

        end do

        ! Request operands based on operation
        if (op_code >= 1 .and. op_code <= 4) then

            ! Binary operations (1-4) need two operands
            write (*, *) ''
            write (*, '(A)', advance='no') 'Enter first complex number: '
            read (*, '(A)') input1

            var1 = parse_complex(input1)

            write (*, *) ''
            write (*, '(A)', advance='no') 'Enter second complex number: '
            read (*, '(A)') input2

            var2 = parse_complex(input2)

        else if (op_code == 5 .or. op_code == 6) then

            ! Unary operations (power, conjugate) need one operand
            write (*, *) ''
            write (*, '(A)', advance='no') 'Enter complex number: '
            read (*, '(A)') input1
            var1 = parse_complex(input1)

        end if

        ! Perform operation
        select case (op_code)

            case (1)
                result = add(var1, var2)

            case (2)
                result = subtract(var1, var2)

            case (3)
                result = multiply(var1, var2)

            case (4)
                result = divide(var1, var2)

            case (5)
                write (*, *) ''
                write (*, '(A)', advance='no') 'Enter exponent (integer): '
                read (*, '(A)') exponent_str
                read (exponent_str, *) exponent

                result = power(var1, exponent)
                
            case (6)
                result = conjugate(var1)

        end select

        ! Display output format menu
        format_option = 0
        do while (format_option < 1 .or. format_option > 3)
            write (*, *) ''
            write (*, '(A)', advance='no') 'Select output format (1-3): '
            read (*, '(A)') format_choice
            read (format_choice, *, iostat=format_option) format_option
            if (format_option < 1 .or. format_option > 3) then
                write (*, *) 'Invalid format. Please enter a number between 1 and 3.'
                format_option = 0
            end if
        end do

        ! Display result
        write (*, *) ''
        write (*, *) 'Result: ', trim(format_complex(result, format_option))

        ! Ask to continue
        write (*, *) ''
        write (*, '(A)', advance='no') 'Perform another calculation? (y/n): '
        read (*, '(A)') continue_choice

        if (continue_choice /= 'y' .and. continue_choice /= 'Y') then

            keep_running = .false.

        end if

    end do

    write (*, *) ''
    write (*, *) 'Thank you for using the Complex Calculator!'
    write (*, *) ''

end program complexCalculator