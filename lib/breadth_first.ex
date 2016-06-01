defmodule BreadthFirst do

  @letters 'abcdefghijklmnopqrstuvwxyz'

  def find_transformation(word, target, dictionary) do
    case target in dictionary && word in dictionary do
      false -> {:not_in_dict, nil}
      true ->
        queue = :queue.from_list([[word]])
        dequeue_result = :queue.out(queue)
        _find_transformation(target, dictionary, dequeue_result)
    end
  end

  # the success scenario
  defp _find_transformation(target, _, {{:value, [last_word|_] = path}, _})
  when last_word == target do

    {:ok, length(path)}
  end

  # the failure scenario
  defp _find_transformation(_, _, {:empty, _}), do: {:no_path, nil}

  defp _find_transformation(target, dictionary, {{:value, [last_word|_] = path}, queue}) do
    updated_queue = last_word
    |> find_permutations(dictionary, path)
    |> construct_new_paths(path)
    |> enqueue_all_new_paths(queue)

    dequeue_result = :queue.out(updated_queue)
    _find_transformation(target, dictionary, dequeue_result)
  end

  defp find_permutations(word, dictionary, exclude) do
    0..(String.length(word) - 1)
    |> Enum.flat_map(&(permute_position(&1, word)))
    |> Enum.filter(fn perm ->
        Enum.member?(dictionary, perm) && !Enum.member?(exclude, perm)
       end)
  end

  defp permute_position(pos, word) do
    word_chars = String.to_char_list(word)

    @letters
    |> Enum.map(&(replace_letter(&1, word_chars, pos)))
    |> Enum.filter(&(&1 != word))
  end

  defp replace_letter(char, chars, pos) do
    chars
    |> List.replace_at(pos, char)
    |> List.to_string
  end

  defp construct_new_paths(permutations, current_path) do
    permutations
    |> Enum.map(&([&1|current_path]))
  end

  defp enqueue_all_new_paths(paths, queue) do
    paths
    |> Enum.reduce(queue, fn(perm, acc_queue) -> :queue.in(perm, acc_queue) end)
  end
end
