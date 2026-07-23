/* Materialize the untidy input file that the tidy-up step reads.
   Upstream created it with `filename ft15f001; parmcards4;`, writing the
   same records to d:/txt/untidy.txt; here we write the identical rows to a
   portable relative path with a DATA _NULL_ step so the bundle is self-
   contained. */
filename untidy "./untidy.txt";
data _null_;
  file untidy;
  input;
  put _infile_;
  datalines4;
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
run;

/* Author's tidy-up logic, unchanged except the infile path. Reads the
   messy file one record at a time, promotes each `test ... response ...`
   subheader into retained TEST/RESPONSE columns, and outputs the detail
   rows underneath it. */
data want;

  retain x y test response;

  infile "./untidy.txt";

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

proc print data=want;
run;
