## RInsideC

Embed R inside a C program or a program written in any language with a C FFI.

### Example: Hello World in C

This program, written in C, tells R to print a message to the screen:

```
void evalQuietlyInR(char * cmd);

int main() {
	evalQuietlyInR("print('Hello, World')");
}
```

You can find this example in inst/examples/hello.c. There is also a Makefile in that directory to do the compilation and run the resulting executable:

```
make hello
```

### Authors

Dirk Eddelbuettel and Romain Francois wrote RInside. Lance Bachmeier made minor modifications to expose their interface to C programs.

### License

GPL (>= 2)
