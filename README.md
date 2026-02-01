# Complex Calculator

Small Fortran program to perform arithmetic on complex numbers (add, subtract, multiply, divide, power, conjugate).

## Prerequisites
- A Fortran compiler (`gfortran`).
- (Optional) `make` on Windows (via MSYS2/MinGW/Chocolatey) for convenience.

## Build
From the project root (`C:\\Users\\Jay\\Working\\ComplexCalculator`):

PowerShell (preferred, uses the included `Makefile`):

```powershell
make
```

If `make` is not available, either use `mingw32-make` (MinGW) or compile directly:

```powershell
gfortran -o complex_calculator.exe types_module.f90 operations_module.f90 parser_module.f90 formatter_module.f90 complex_calculator.f90
```

## Run
After building:

```powershell
# with Makefile
make run

# or run the executable directly
.\complex_calculator.exe
```

## Usage (interactive)
The program prompts for:
- Operation (1-6): addition, subtraction, multiplication, division, power, conjugate
- Complex operands in one of these formats:
	- `(real,imag)` e.g. `(3.0,4.0)`
	- `real+imag*i` e.g. `3.0+4.0*i`
	- `real` e.g. `5.0`
- Output format (1-3):
	1. `(real,imag)`
	2. `real+imag*i`
	3. If imaginary part ≈ 0, show only real; otherwise show `real±imag*i`

Example session (conjugate):
```
Enter operation (1-6): 6
Enter complex number: 1+4*i
Select output format (1-3): 2
Result: 1.00-4.00*i
```