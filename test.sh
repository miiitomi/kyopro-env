problem_name=$1
ext_name=$2
file=$3
relative_file_dir_name=$4
ac_library_path=$5
contest_name=${relative_file_dir_name##*/}
url=https://atcoder.jp/contests/${contest_name}/tasks/${contest_name}_${problem_name}

cd ${relative_file_dir_name}
oj dl -d samples/ ${url}

if [ ${ext_name} = ".cpp" ]; then
    g++ ${file} -std=gnu++23 -Wall -Wextra -O2 -I ${ac_library_path} -o ${problem_name}.out && oj test -c "./${problem_name}.out" -d samples/
    rm ./${problem_name}.out
elif [ ${ext_name} = ".py" ]; then
    oj test -c "python3 ${file}" -d samples/
else
    echo "Not supported language"
fi

rm -rf samples/
