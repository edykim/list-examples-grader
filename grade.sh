# Create your grading script here

# set -e

EXAMPLE_FILE_NAME="ListExamples.java"
CLASS_NAME="class ListExamples"

echo "Code Grader"
echo "Target URL: $1"
echo ""

rm -rf student-submission
git clone $1 student-submission -q

if [[ $? -eq 0 ]]
then
  echo "[PASSED] Cloned successfully."
else
  echo "[FAILED] Clone failed. Check the submit URL."
  exit 1
fi

cd student-submission

if [[ -f $EXAMPLE_FILE_NAME ]]
then
  echo "[PASSED] File Found ($EXAMPLE_FILE_NAME)"
else
  echo "[FAILED] File Not Found ($EXAMPLE_FILE_NAME)"
  exit 1
fi

grep -q "$CLASS_NAME" ./$EXAMPLE_FILE_NAME

if [[ $? -eq 0 ]]
then
  echo "[PASSED] Text Found ($CLASS_NAME)"
else
  echo "[FAILED] Text Not Found ($CLASS_NAME)"
  exit 1
fi

CP=".:../lib/hamcrest-core-1.3.jar:../lib/junit-4.13.2.jar"

cp ../TestListExamples.java .
javac -cp $CP *.java 2> compile_error.txt

if [[ $? -eq 0 ]]
then
  echo "[PASSED] Compiled successfully."
else
  MSG=`cat compile_error.txt | head -1`
  echo "[FAILED] Compile Failed. ($MSG)"
  exit 1
fi

rm -rf test_result.txt
java -cp $CP org.junit.runner.JUnitCore TestListExamples > test_result.txt

JUNIT_EXIT_CODE=$?


if [[ $JUNIT_EXIT_CODE -eq 0 ]]
then
  RESULT=`cat test_result.txt | grep "OK"`
  echo "[PASSED] jUnit result: " $RESULT
else
  RESULT=`cat test_result.txt | grep "Tests run:"`
  echo "[FAILED] jUnit result: " $RESULT
  exit 1
fi

