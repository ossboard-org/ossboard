# frozen_string_literal: true

RSpec.describe Interactors::Issues::Show do
  let(:is_valid) { true }
  let(:params) { { issue_url: Faker::Internet.url } }
  let(:interactor) { Interactors::Issues::Show }

  describe '#initialize' do
    it 'instantiates class with 2 arguments' do
      expect(interactor).to receive(:new).with(is_valid, params)
      interactor.new(is_valid, params)
    end
  end

  describe '#call' do
    context 'when @is_valid is true' do
      subject { interactor.new(is_valid, params) }
      it 'calls match_host method' do
        expect(subject).to receive(:match_host).with(params[:issue_url])
        subject.call
      end
    end

    context 'when @is_valid is false' do
      subject { interactor.new(false, params) }
      it 'returns error' do
        result = subject.call
        expect(result.errors).to include('invalid params')
        expect(result.failure?).to be_truthy
      end
    end
  end
end
