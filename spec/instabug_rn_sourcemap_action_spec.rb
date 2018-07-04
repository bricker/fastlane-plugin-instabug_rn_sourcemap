describe Fastlane::Actions::InstabugRnSourcemapAction do
  describe '#run' do
    it 'prints a message' do
      expect(Fastlane::UI).to receive(:message).with("The instabug_rn_sourcemap plugin is working!")

      Fastlane::Actions::InstabugRnSourcemapAction.run(nil)
    end
  end
end
