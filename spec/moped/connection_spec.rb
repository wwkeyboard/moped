require "spec_helper"

describe Moped::Connection do

  describe "#alive?" do

    let(:connection) do
      described_class.new("127.0.0.1", 27017, 2)
    end

    after do
      connection.disconnect
    end

    context "when the socket is alive" do

      before do
        connection.connect
      end

      it "returns true" do
        expect(connection).to be_alive
      end
    end

    context "when the socket is not alive" do

      before do
        connection.connect
        connection.instance_variable_get(:@sock).close
      end

      it "returns false" do
        expect(connection).to_not be_alive
      end
    end

    context "when the socket is nil" do

      it "returns false" do
        expect(connection).to_not be_alive
      end
    end
  end

  pending "#connect" do

    context "when using ssl" do

    end

    context "when using tcp" do

    end

    context "when using unix" do

    end
  end

  describe "#connected?" do

    let(:connection) do
      described_class.new("127.0.0.1", 27017, 2)
    end

    context "when the connection is connected" do

      before do
        connection.connect
      end

      after do
        connection.disconnect
      end

      it "returns true" do
        expect(connection).to be_connected
      end
    end

    context "when the connection is not connected" do

      it "returns false" do
        expect(connection).to_not be_connected
      end
    end
  end

  describe "#disconnect" do

    let(:connection) do
      described_class.new("127.0.0.1", 27017, 2)
    end

    before do
      connection.connect
      connection.disconnect
    end

    it "disconnects the connection" do
      expect(connection).to_not be_connected
    end

    it "sets the socket to nil" do
      expect(connection.instance_variable_get(:@sock)).to be_nil
    end
  end

  describe "#expire" do

    let(:connection) do
      described_class.new("127.0.0.1", 27017, 2)
    end

    before do
      connection.lease
      connection.expire
    end

    it "unsets the last_use time" do
      expect(connection.last_use).to be_nil
    end
  end

  describe "#expired?" do

    let(:connection) do
      described_class.new("127.0.0.1", 27017, 2)
    end

    context "when the connection has a last_use" do

      before do
        connection.lease
      end

      it "returns false" do
        expect(connection).to_not be_expired
      end
    end

    context "when the connection does not have a last_use" do

      before do
        connection.expire
      end

      it "returns true" do
        expect(connection).to be_expired
      end
    end
  end

  describe "#lease" do

    let(:connection) do
      described_class.new("127.0.0.1", 27017, 2)
    end

    before do
      connection.lease
    end

    it "sets the last_use time" do
      expect(connection.last_use).to be_within(1).of(Time.now)
    end
  end

  pending "#read" do

  end

  pending "#write" do

    context "when providing a single operation" do

    end

    context "when providing multiple operations" do

    end
  end
end
