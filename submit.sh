problem_name=$1
file=$2
relative_file_dir_name=$3
ext_name=$4
contest_name=${relative_file_dir_name##*/}

url=https://atcoder.jp/contests/${contest_name}/tasks/${contest_name}_${problem_name}

if [ ${ext_name} = ".py" ]; then
    oj submit --yes --guess-python-interpreter pypy ${url} ${file}
else
    oj submit --yes ${url} ${file}
fi
