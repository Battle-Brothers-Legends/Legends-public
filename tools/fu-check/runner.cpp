// Small native Squirrel runner for FU checks. This does not emulate the game.
#include <cstdio>
#include <cstdarg>
#include <cstring>
#include <squirrel.h>
#include <sqstdaux.h>
#include <sqstdio.h>
#include <sqstdmath.h>
#include <sqstdstring.h>
#include <sqstdsystem.h>
#include <sqstdblob.h>

static void output(HSQUIRRELVM, const SQChar *format, ...) {
    va_list args;
    va_start(args, format);
    vfprintf(stderr, format, args);
    va_end(args);
}

int main(int argc, char **argv) {
    if (argc < 2) return 2;
    HSQUIRRELVM vm = sq_open(1024);
    sq_setprintfunc(vm, output, output);
    sqstd_seterrorhandlers(vm);
    sq_pushroottable(vm);
    sqstd_register_iolib(vm);
    sqstd_register_mathlib(vm);
    sqstd_register_stringlib(vm);
    sqstd_register_systemlib(vm);
    sqstd_register_bloblib(vm);
    bool failed = false;
    if (!strcmp(argv[1], "--compile")) {
        for (int i = 2; i < argc; ++i) {
            if (SQ_FAILED(sqstd_loadfile(vm, argv[i], SQTrue))) failed = true;
            else sq_pop(vm, 1);
        }
    } else {
        failed = SQ_FAILED(sqstd_dofile(vm, argv[1], SQFalse, SQTrue));
    }
    sq_close(vm);
    return failed ? 1 : 0;
}
