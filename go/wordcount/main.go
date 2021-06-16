package main

import (
	"bufio"
	"fmt"
	"log"
	"os"
  "sort"
	"strings"
)

type WordCount struct {
  Word string
  Count int
}

type WordCountList []WordCount

// functions in the sort interface:
func (list WordCountList) Len() int { 
  return len(list)
}

func (list WordCountList) Less(i int, j int) bool { 
  return list[i].Count < list[j].Count 
}

func (list WordCountList) Swap(i int, j int) {
  list[i], list[j] = list[j], list[i] 
}


func main() {
  file_name := "./resume_rod_doe.md"

  file, err := os.Open(file_name)
  if err != nil {
    log.Fatal(err) 
  }
  defer file.Close()

  count_by_word := make(map[string]int)

  scanner := bufio.NewScanner(file)
  // Scan to create map of key = word, value = count:
  for scanner.Scan() {
    line := scanner.Text()
    words := strings.Fields(line)
    for _, word := range words {
      lc_word := strings.ToLower(word)
      count_by_word[lc_word] = count_by_word[lc_word] + 1
    }
  }


  // Copy map members into list for sorting:
  word_count_list := make(WordCountList, len(count_by_word))
  i := 0

  for word, count := range count_by_word {
    word_count_list[i] = WordCount{word, count}
    i++
  }

  // Sort in reverse order:
  sort.Sort((sort.Reverse(word_count_list)))

  // Print sorted list:
  for _, item := range word_count_list {
    fmt.Println(fmt.Sprintf("%s : %d", item.Word, item.Count))
  }

}
