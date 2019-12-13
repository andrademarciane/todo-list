require 'rails_helper'

describe StepsController do
  let(:task) { create(:task, board: create(:board)) }

  describe 'POST steps_controller#create' do
    context 'when data is valid' do
      let(:step_params) { { step: attributes_for(:step, task: task).merge(task_id: task.id)} }

      it 'should create a step' do
        expect { post :create, params: step_params }
            .to change { Step.count }
                    .from(0).to(1)
      end
    end

    context 'when data is invalid' do
      let(:step_params) { { step: attributes_for(:step, name: nil, task: task).merge(task_id: task.id)} }

      it 'should create a step' do
        expect { post :create, params: step_params }
            .not_to change { Step.count }
                    .from(0)
      end
    end
  end

  describe 'PUT steps_controller#update' do
    let(:step) { create(:step, task: task) }
    let(:step_params) { { step: attributes_for(:step, name: new_name, task: task), id: step.id } }

    context 'when data is valid' do
      let(:new_name) {'New Name'}

      it 'should update the step' do
        expect { put :update, params: step_params }
            .to change { step.reload.name }
                    .from(step.name).to('New Name')
      end
    end

    context 'when data is invalid' do
      let(:new_name) {nil}

      it 'should create a step' do
        expect { post :create, params: step_params }
            .not_to change { step.reload.name }
                        .from(step.name)
      end
    end
  end

  describe 'DELETE steps_controller#destroy' do
    let!(:step) { create(:step, task: task) }
    let(:step_params) { { id: step.id } }

    it 'should destroy the step' do
      expect { delete :destroy, params: step_params }
          .to change { Step.count }
                  .from(1).to(0)
    end
  end
end