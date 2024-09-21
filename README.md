# utl-tidy-up-a-messy-text-file-holding-input-records
Tidy up a messy text file holding input records
    %let pgm=utl-tidy-up-a-messy-text-file-holding-input-records;

    Tidy up a messy text file holding input records

    github
    https://tinyurl.com/23uxb69p
    https://github.com/rogerjdeangelis/utl-tidy-up-a-messy-text-file-holding-input-records

    SOAPBOX ON

    Before there were relational databases there were text files,
      ie IBM VSAM, QSAM, KSDS, ESDS and LDS
    Header and trailer records were commmon

    COBOL, FORTRAN manipulated these.

    Thse files were the primary input for early sas, sas grew up with them and developed
    very powerfull tecnoology to deal with them.

    NOTE: The R solutions require at least two packages thet require niche syntax

    Below is an example

    SOAPBOX OFF

    statckoverflow r
    https://tinyurl.com/485xswbs
    https://stackoverflow.com/questions/79009545/tidy-up-datasets-converting-subheaders-into-column

    /*               _     _
     _ __  _ __ ___ | |__ | | ___ _ __ ___
    | `_ \| `__/ _ \| `_ \| |/ _ \ `_ ` _ \
    | |_) | | | (_) | |_) | |  __/ | | | | |
    | .__/|_|  \___/|_.__/|_|\___|_| |_| |_|
    |_|
    */

    /**************************************************************************************************************************/
    /*                                                                                                                        */
    /*  INPUT TEXT FILE                 PROCESS (SELF EXPANATORY?)                             OUTPUT                         */
    /*  ===============                 ==========================                             ======                         */
    /*                                                                                                                        */
    /*  d:/txt/untidy.txt           data want;                                     X       Y     TEST      RESPONSE           */
    /*                                                                                                                        */
    /*  test A response c             retain x y test response;                    x1      1    test A    response c          */
    /*  x1     1                                                                   x2      0    test A    response c          */
    /*  x2     0                      infile "d:/txt/untidy.txt";                  x324    5    test A    response c          */
    /*  x324   5                                                                   x1      2    test P    response 8          */
    /*  test P response 8             input @; /* hold the record */               x2      1    test P    response 8          */
    /*  x1     2                                                                   x501    4    test P    response 8          */
    /*  x2     1                      if _infile_ =: 'test' then do;               x1      2    test 7    response t          */
    /*  x501   4                         test     = substr(_infile_,1,6);          x2      1    test 7    response t          */
    /*  test 7 response t                response = substr(_infile_,8);            x936    4    test 7    response t          */
    /*  x1     2                      end;                                                                                    */
    /*  x2     1                                                                                                              */
    /*  x936   4                      else do;                                                                                */
    /*                                   input x$ y$;                                                                         */
    /*                                   output;                                                                              */
    /*                                end;                                                                                    */
    /*                                                                                                                        */
    /*                              run;quit;                                                                                 */
    /*                                                                                                                        */
    /*------------------------------------------------------------------------------------------------------------------------*/
    /*                                                                                                                        */
    /*                              library(tidyr)                                                                            */
    /*                              library(dplyr)                                                                            */
    /*                                                                                                                        */
    /*                              df |>                                                                                     */
    /*                                mutate(Test =                                                                           */
    /*                                   replace(x, !grepl("test", x), NA),                                                   */
    /*                                   Response = replace(y                                                                 */
    /*                                   ,!grepl("response", y), NA)) |>                                                      */
    /*                                fill(Test, Response) |>                                                                 */
    /*                                filter(!grepl("test", x))                                                               */
    /*                                                                                                                        */
    /*------------------------------------------------------------------------------------------------------------------------*/
    /*                                                                                                                        */
    /*                              library(readr)                                                                            */
    /*                              library(purrr)                                                                            */
    /*                              library(tidyr)                                                                            */
    /*                              library(stringr)                                                                          */
    /*                                                                                                                        */
    /*                              # replace `txt` with txt file name                                                        */
    /*                              txt_lines <- read_lines(txt)                                                              */
    /*                              (sections <- str_detect(txt_lines,                                                        */
    /*                                 "^#") |> cumsum())                                                                     */
    /*                              #>  [1] 1 1 1 1 2 2 2 2 3 3 3 3                                                           */
    /*                                                                                                                        */
    /*                                # split by sections                                                                     */
    /*                              split(txt_lines, sections) |>                                                             */
    /*                                (\(x) set_names(x                                                                       */
    /*                                   ,map_chr(x, 1)))() |>                                                                */
    /*                                map(read_table, col_types = "_ci"                                                       */
    /*                                   ,col_names = c("x", "y"), skip = 1) |>                                               */
    /*                                   list_rbind(names_to = "header") |>                                                   */
    /*                                    separate_wider_regex(header                                                         */
    /*                                       ,patterns = c("^#\\s*"                                                           */
    /*                                       ,Test = ".*(?= response)"                                                        */
    /*                                       ,"\\s*", Response = ".*"))                                                       */
    /*                                                                                                                        */
    /**************************************************************************************************************************/

    /*                   _
    (_)_ __  _ __  _   _| |_
    | | `_ \| `_ \| | | | __|
    | | | | | |_) | |_| | |_
    |_|_| |_| .__/ \__,_|\__|
            |_|
    */


    filename ft15f001 "d:/txt/untidy.txt";
    parmcards4;
    test A response c
    x1     1
    x2     0
    x324   5
    test P response 8
    x1     2
    x2     1
    x501   4
    test 7 response t
    x1     2
    x2     1
    x936   4
    ;;;;
    run;quit;

    /**************************************************************************************************************************/
    /*                                                                                                                        */
    /*  d:/txt/untidy.txt                                                                                                     */
    /*                                                                                                                        */
    /*  test A response c                                                                                                     */
    /*  x1     1                                                                                                              */
    /*  x2     0                                                                                                              */
    /*  x324   5                                                                                                              */
    /*  test P response 8                                                                                                     */
    /*  x1     2                                                                                                              */
    /*  x2     1                                                                                                              */
    /*  x501   4                                                                                                              */
    /*  test 7 response t                                                                                                     */
    /*  x1     2                                                                                                              */
    /*  x2     1                                                                                                              */
    /*  x936   4                                                                                                              */
    /*                                                                                                                        */
    /**************************************************************************************************************************/

    /*
     _ __  _ __ ___   ___ ___  ___ ___
    | `_ \| `__/ _ \ / __/ _ \/ __/ __|
    | |_) | | | (_) | (_|  __/\__ \__ \
    | .__/|_|  \___/ \___\___||___/___/
    |_|
    */

    data want;

      retain x y test response;

      infile "d:/txt/untidy.txt";

      input @; /* hold the record */

      if _infile_ =: 'test' then do;
         test     = substr(_infile_,1,6);
         response = substr(_infile_,8);
      end;

      else do;
         input x$ y;
         output;
      end;

    run;quit;

    /**************************************************************************************************************************/
    /*                                                                                                                        */
    /* WORK.WANT total obs=9                                                                                                  */
    /*                                                                                                                        */
    /* Obs    X       Y     TEST      RESPONSE                                                                                */
    /*                                                                                                                        */
    /*  1     x1      1    test A    response c                                                                               */
    /*  2     x2      0    test A    response c                                                                               */
    /*  3     x324    5    test A    response c                                                                               */
    /*  4     x1      2    test P    response 8                                                                               */
    /*  5     x2      1    test P    response 8                                                                               */
    /*  6     x501    4    test P    response 8                                                                               */
    /*  7     x1      2    test 7    response t                                                                               */
    /*  8     x2      1    test 7    response t                                                                               */
    /*  9     x936    4    test 7    response t                                                                               */
    /*                                                                                                                        */
    /**************************************************************************************************************************/

    /*              _
      ___ _ __   __| |
     / _ \ `_ \ / _` |
    |  __/ | | | (_| |
     \___|_| |_|\__,_|

    */
