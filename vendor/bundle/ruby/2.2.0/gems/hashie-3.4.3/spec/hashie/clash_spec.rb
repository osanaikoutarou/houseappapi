require 'spec_helper'

describe Hashie::Clash do
  subject { Hashie::Clash.new }

  it 'is able to set an attribute via method_missing' do
    subject.foo('bar')
    expect(subject[:foo]).to eq 'bar'
  end

  it 'is able to set multiple attributes' do
    subject.foo('bar').baz('wok')
    expect(subject).to eq(foo: 'bar', baz: 'wok')
  end

  it 'converts multiple arguments into an array' do
    subject.foo(1, 2, 3)
    expect(subject[:foo]).to eq [1, 2, 3]
  end

  it 'is able to use bang notation to create a new Clash on a key' do
    subject.foo!
    expect(subject[:foo]).to be_kind_of(Hashie::Clash)
  end

  it 'is able to chain onto the new Clash when using bang notation' do
    subject.foo!.bar('abc').baz(123)
    expect(subject).to eq(foo: { bar: 'abc', baz: 123 })
  end

  it 'is able to jump back up to the parent in the chain with #_end!' do
    subject.foo!.bar('abc')._end!.baz(123)
    expect(subject).to eq(foo: { bar: 'abc' }, baz: 123)
  end

  it 'merges rather than replaces existing keys' do
    subject.where(abc: 'def').where(hgi: 123)
    expect(subject).to eq(where: { abc: 'def', hgi: 123 })
  end

  it 'is able to replace all of its own keys with #replace' do
    subject.foo(:bar).hello(:world)
    expect(subject.replace(baz: 123, hgi: 123)).to eq(baz: 123, hgi: 123)
    expect(subject).to eq(baz: 123, hgi: 123)
    expect(subject[:foo]).to be_nil
    expect(subject[:hello]).to be_nil
  end
end
