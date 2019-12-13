require 'rails_helper'

describe BoardsController do
  describe 'POST boards_controller#create' do
    context 'when data is valid' do
      let(:board_params) { {board: attributes_for(:board)} }

      it 'should create a board' do
        expect { post :create, params: board_params }
            .to change { Board.count }
                    .from(0).to(1)
      end
    end

    context 'when data is invalid' do
      let(:board_params) { {board: attributes_for(:board, name: nil)} }

      it 'should create a board' do
        expect { post :create, params: board_params }
            .not_to change { Board.count }
                        .from(0)
      end
    end
  end

  describe 'PUT boards_controller#update' do
    let(:board) { create(:board) }
    let(:board_params) { {board: attributes_for(:board, name: new_name), id: board.id} }

    context 'when data is valid' do
      let(:new_name) { 'New Name' }

      it 'should update the board' do
        expect { put :update, params: board_params }
            .to change { board.reload.name }
                    .from(board.name).to('New Name')
      end
    end

    context 'when data is invalid' do
      let(:new_name) { nil }

      it 'should create a board' do
        expect { post :create, params: board_params }
            .not_to change { board.reload.name }
                        .from(board.name)
      end

      describe 'tasks CRUD' do
        describe 'create task' do
          context 'when data is valid' do
            let(:board_params) { {board: {tasks_attributes: [attributes_for(:task)]}, id: board.id} }

            it 'should create task' do
              expect { put :update, params: board_params }
                  .to change { Task.where(board_id: board.id).count }
                          .from(0).to(1)
            end
          end

          context 'when data is invalid' do
            let(:board_params) { {board: {tasks_attributes: [attributes_for(:task, name: nil)]}, id: board.id} }

            it 'should create a board' do
              expect { post :create, params: board_params }
                  .not_to change { Task.where(board_id: board.id).count }
                              .from(0)
            end
          end
        end

        describe 'update task' do
          let(:task) { create(:task, board: board) }
          let(:board_params) { {board: {tasks_attributes: [{ id: task.id, name: new_name}]}, id: board.id} }

          context 'when data is valid' do

            let(:new_name) { 'New Name' }
            it 'should create task' do
              expect { put :update, params: board_params }
                  .to change { task.reload.name }
                          .from(task.name).to(new_name)
            end
          end

          context 'when data is invalid' do

            let(:new_name) { nil }

            it 'should create a board' do
              expect { put :update, params: board_params }
                  .not_to change { task.reload.name }
                              .from(task.name)
            end
          end
        end

        describe 'destroy task' do
          let!(:task) { create(:task, board: board) }
          let(:board_params) { {board: {tasks_attributes: [{ id: task.id, _destroy: true}]}, id: board.id} }

          context 'when data is valid' do
            it 'should create task' do
              expect { put :update, params: board_params }
                  .to change { Task.where(board_id: board.id).count }
                          .from(1).to(0)
            end
          end
        end
      end
    end
  end

  describe 'DELETE boards_controller#destroy' do
    let!(:board) { create(:board) }
    let(:board_params) { {id: board.id} }

    it 'should destroy the board' do
      expect { delete :destroy, params: board_params }
          .to change { Board.count }
                  .from(1).to(0)
    end
  end
end