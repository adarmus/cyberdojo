#!/usr/bin/env ruby

require File.dirname(__FILE__) + '/model_test_case'

class ExerciseTests < ModelTestCase

  test 'path(exercise)' do
    json_and_rb do
      exercise = @dojo.exercises['test_Yahtzee']
      assert exercise.path.match(exercise.name)
      assert path_ends_in_slash?(exercise)
      assert !path_has_adjacent_separators?(exercise)
    end
  end

  #- - - - - - - - - - - - - - - - - - - - - -

  test 'exists? is true only if dir and instructions exist' do
    json_and_rb do
      exercise = @dojo.exercises['test_Yahtzee']
      assert !exercise.exists?
      exercise.dir.make
      assert !exercise.exists?
      exercise.dir.spy_exists?('instructions')
      assert exercise.exists?
    end
  end

  #- - - - - - - - - - - - - - - - - - - - - -

  test 'name is as set in ctor' do
    json_and_rb do
      exercise = @dojo.exercises['test_Yahtzee']
      assert_equal 'test_Yahtzee', exercise.name
    end
  end

  #- - - - - - - - - - - - - - - - - - - - - -

  test 'instructions are loaded from file of same name' do
    json_and_rb do
      exercise = @dojo.exercises['test_Yahtzee']
      filename = 'instructions'
      content = 'The game of Yahtzee...'
      exercise.dir.spy_read(filename, content)
      assert_equal content, exercise.instructions
      assert exercise.dir.log.include?(['read',filename,content])
    end
  end

end
