"""General method to get word counts in a text document."""

def text_doc_word_iter(handle):
    for line in handle.readlines():
        words = line.split()
        for word in words:
            yield word


def get_doc_word_count(file_path):
    count_by_word = {}
    fh = open(file_path, 'r')
    for word in text_doc_word_iter(fh):
        lc_word = word.lower()
        count_by_word[lc_word] = count_by_word.get(lc_word, 0) + 1

    return count_by_word

def main():
    d = get_doc_word_count('./resume_rod_doe.md')
    s = sorted(d, key=lambda word: int(d[word]), reverse=True)
    # s = sorted(d, key=lambda x : int(d[x]), reverse=True)
    for key in s:
        print(f"{key} {d[key]}")
    

if __name__ == '__main__':
    main()
