class CreateQuestionsAnswers < ActiveRecord::Migration
  def change
    create_table :questions_answers do |t|
      t.text :question
      t.text :answer
      t.boolean :answered

      t.timestamps
    end
  end
end
