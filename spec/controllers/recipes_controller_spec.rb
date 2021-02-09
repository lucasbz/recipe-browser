# frozen_string_literal: true

require 'spec_helper'

RSpec.describe 'RecipesController', type: :controller do
  context '#index' do
    subject { get :index }

    it { expect(response).to have_http_status(:ok) }
  end

  context '#show' do
    subject { get :show, id: '4dT8tcb6ukGSIg2YyuGEOm' }

    it { expect(response).to have_http_status(:ok) }
  end
end
