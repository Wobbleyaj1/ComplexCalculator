# Compiler and flags
FC = gfortran
FFLAGS = -Wall

# Target executable
TARGET = complex_calculator.exe

# Source files
SOURCES = types_module.f90 operations_module.f90 parser_module.f90 formatter_module.f90 complex_calculator.f90

# Object files
OBJECTS = $(SOURCES:.f90=.o)

# Default target
all: $(TARGET)

# Build the executable
$(TARGET): $(OBJECTS)
	$(FC) $(FFLAGS) -o $(TARGET) $(OBJECTS)

# Compile modules in order
types_module.o: types_module.f90
	$(FC) $(FFLAGS) -c types_module.f90

operations_module.o: operations_module.f90 types_module.o
	$(FC) $(FFLAGS) -c operations_module.f90

parser_module.o: parser_module.f90 types_module.o
	$(FC) $(FFLAGS) -c parser_module.f90

formatter_module.o: formatter_module.f90 types_module.o
	$(FC) $(FFLAGS) -c formatter_module.f90

complex_calculator.o: complex_calculator.f90 types_module.o operations_module.o parser_module.o formatter_module.o
	$(FC) $(FFLAGS) -c complex_calculator.f90

# Run the program
run: $(TARGET)
	./$(TARGET)

# Clean build artifacts
clean:
	del /Q *.o *.mod $(TARGET)

.PHONY: all run clean
