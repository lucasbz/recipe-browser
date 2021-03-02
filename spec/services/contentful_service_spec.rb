# frozen_string_literal: true

require 'spec_helper'

RSpec.describe 'ContentfulService#all)recipes' do
  context 'ContentfulService#all)recipes' do
    let(:client_double) { instance_double('Contentful::Client') }
    before { allow(Contentful::Client).to receive(:new).and_return(client_double) }
    let(:full_entry) do
      double('Contentful::Entry',
             id: 'full_entry',
             title: 'White Cheddar Grilled Cheese with Cherry Preserves & Basil',
             description: 'White Cheddar Grilled Cheese with Cherry Preserves & Basil',
             photo: double('Contentful::Entry', url: '//image_url'),
             tags: [double('Contentful::Entry', name: 'vegan'),
                    double('Contentful::Entry', name: 'gluten free')],
             chef: double('Contentful::Entry', name: 'Jony Chives!'))
    end

    before do
      expect(client_double).to receive(:entries).with(include: 2, content_type: 'recipe').and_return([full_entry])
    end

    subject { ContentfulService.new.all_recipes }

    it { expect(subject[0].id).to eq('full_entry') }
    it { expect(subject[0].title).to eq('White Cheddar Grilled Cheese with Cherry Preserves & Basil') }
    it { expect(subject[0].photo.url).to eq('http://image_url') }
  end

  context 'ContentfulService#find_recipe_with_all_info' do
    let(:client_double) { instance_double('Contentful::Client') }
    before { allow(Contentful::Client).to receive(:new).and_return(client_double) }
    before { expect(client_double).to receive(:entry).with('full_entry').and_return(full_entry) }
    let(:full_entry) do
      double('Contentful::Entry',
             id: 'full_entry',
             title: 'White Cheddar Grilled Cheese with Cherry Preserves & Basil',
             description: 'White Cheddar Grilled Cheese with Cherry Preserves & Basil',
             photo: double('Contentful::Entry', url: '//image_url'),
             tags: [double('Contentful::Entry', name: 'vegan'),
                    double('Contentful::Entry', name: 'gluten free')],
             chef: double('Contentful::Entry', name: 'Jony Chives!'))
    end

    subject { ContentfulService.new.find_recipe('full_entry') }

    it { expect(subject.id).to eq('full_entry') }
    it { expect(subject.photo.url).to eq('http://image_url') }
    it { expect(subject.tags.map(&:name)).to include('vegan') }
    it { expect(subject.tags.map(&:name)).to include('gluten free') }
    it { expect(subject.chef.name).to eq('Jony Chives!') }
  end

  context 'ContentfulService#find_recipe_with_no_tags' do
    let(:client_double) { instance_double('Contentful::Client') }
    before { allow(Contentful::Client).to receive(:new).and_return(client_double) }
    let(:entry_with_no_tags) do
      entry_with_no_tags = double('Contentful::Entry',
                                  id: 'entry_with_no_tags',
                                  title: 'White Cheddar Grilled Cheese with Cherry Preserves & Basil',
                                  description: 'White Cheddar Grilled Cheese with Cherry Preserves & Basil',
                                  photo: double('Contentful::Entry', url: '//image_url'),
                                  chef: double('Contentful::Entry', name: 'Jony Chives!'))

      allow(entry_with_no_tags).to receive(:tags).and_raise(Contentful::EmptyFieldError.new('tags'))
      entry_with_no_tags
    end

    before { expect(client_double).to receive(:entry).with('entry_with_no_tags').and_return(entry_with_no_tags) }

    subject { ContentfulService.new.find_recipe('entry_with_no_tags') }

    it { expect(subject.id).to eq('entry_with_no_tags') }
    it { expect(subject.photo.url).to eq('http://image_url') }
    it { expect(subject.tags).to be_empty }
    it { expect(subject.tags).to be_empty }
    it { expect(subject.chef.name).to eq('Jony Chives!') }
    it { expect { subject }.not_to raise_error }
  end

  context 'ContentfulService#find_recipe_with_no_chef' do
    let(:client_double) { instance_double('Contentful::Client') }
    before { allow(Contentful::Client).to receive(:new).and_return(client_double) }
    let(:entry_with_no_chef) do
      entry_with_no_chef = double('Contentful::Entry',
                                  id: 'entry_with_no_chef',
                                  title: 'White Cheddar Grilled Cheese with Cherry Preserves & Basil',
                                  description: 'White Cheddar Grilled Cheese with Cherry Preserves & Basil',
                                  photo: double('Contentful::Entry', url: '//image_url'),
                                  tags: [double('Contentful::Entry', name: 'vegan'),
                                         double('Contentful::Entry', name: 'gluten free')])

      allow(entry_with_no_chef).to receive(:chef).and_raise(Contentful::EmptyFieldError.new('tags'))
      entry_with_no_chef
    end

    before { expect(client_double).to receive(:entry).with('entry_with_no_chef').and_return(entry_with_no_chef) }

    subject { ContentfulService.new.find_recipe('entry_with_no_chef') }

    it { expect(subject.id).to eq('entry_with_no_chef') }
    it { expect(subject.photo.url).to eq('http://image_url') }
    it { expect(subject.tags.map(&:name)).to include('vegan') }
    it { expect(subject.tags.map(&:name)).to include('gluten free') }
    it { expect(subject.chef).to be_nil }
    it { expect { subject }.not_to raise_error }
  end
end
