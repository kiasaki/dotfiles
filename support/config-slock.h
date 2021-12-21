/* user and group to drop privileges to */
static const char *user = "nobody";
static const char *group = "nobody";

static const char *colorname[NUMCOLS] = {
    [INIT] = "#8abeb7",   /* after initialization */
    [INPUT] = "#eeeeee",  /* during input */
    [FAILED] = "#cc6666", /* wrong password */
};

/* treat a cleared input like a wrong password (color) */
static const int failonclear = 1;
