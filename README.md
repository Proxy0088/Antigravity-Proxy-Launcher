# 🚀 Antigravity Proxy Launcher

### Run Google Antigravity through a local proxy — without TUN mode.

A lightweight Windows launcher that configures proxy environment variables and starts Google Antigravity through your local HTTP proxy.

Designed for users who want to use Antigravity with VPN applications such as **v2rayN, Clash, Clash Verge, Hiddify, Nekoray**, and other compatible proxy clients — without enabling TUN mode.

---

## ✨ Features

- **No TUN Mode Required** — Uses your VPN application's local HTTP proxy.
- **Easy to Use** — Just double-click the `.bat` file.
- **Automatic Detection** — Searches common Antigravity installation paths.
- **Custom Proxy Configuration** — Configure your own local proxy host and port.
- **Proxy Connectivity Check** — Checks whether the local proxy port is available before launching.
- **No Permanent System Changes** — Does not modify Windows proxy settings, DNS, registry, or hosts file.
- **Lightweight** — No installation, additional dependencies, or administrator privileges required.

## 📋 Requirements

Before using the launcher, make sure you have:

- Windows with Windows PowerShell available.
- Google Antigravity installed.
- A running VPN or proxy client.
- A local HTTP proxy or HTTP-compatible mixed port.

### Supported Proxy Clients

The launcher is designed to work with compatible local HTTP proxy ports from applications such as:

| Proxy Client | Support |
|---|---|
| v2rayN | ✅ HTTP / Mixed port |
| Clash | ✅ HTTP / Mixed port |
| Clash Verge | ✅ HTTP / Mixed port |
| Hiddify | ✅ If HTTP proxy is exposed |
| Nekoray | ✅ HTTP / Mixed port |
| Other clients | ✅ If HTTP-compatible |

*Compatibility depends on your proxy configuration, not just the application name.*

---

## ⚡ Quick Start

**1.** Start your VPN/proxy application.

**2.** Enable its local HTTP proxy or HTTP-compatible Mixed port.

**3.** Download `Antigravity-Proxy.bat` from this repository.

**4.** Double-click the file.

**5.** Antigravity should launch using your local proxy.

That's it!

---

## ⚙️ Configuration

Open `Antigravity-Proxy.bat` with Notepad.

At the top of the file, find:

```bat
set "PROXY_HOST=127.0.0.1"
set "PROXY_PORT=10810"
```

Change the port to match your VPN application's local HTTP or Mixed port.

For example:

```bat
set "PROXY_HOST=127.0.0.1"
set "PROXY_PORT=7890"
```

Save the file and launch it again.

### Custom Antigravity Installation Path

If the launcher cannot automatically find Antigravity, you can manually specify its location:

```bat
set "ANTIGRAVITY_EXE=C:\Path\To\Antigravity.exe"
```

---

## 🔍 How Does It Work?

Some applications do not automatically use the Windows system proxy.

This launcher addresses that by setting proxy environment variables before starting Antigravity:

```bat
set "HTTP_PROXY=http://127.0.0.1:10810"
set "HTTPS_PROXY=http://127.0.0.1:10810"
set "ALL_PROXY=http://127.0.0.1:10810"
```

It also sets lowercase equivalents for compatibility.

These variables are inherited by child processes launched by Antigravity, provided those processes support environment-based proxy configuration.

**Important:** The launcher does not force every internal Antigravity component to use the proxy. Some components may use independent networking configurations.

---

## ⚠️ Important Notes

- Use an **HTTP proxy** or an **HTTP-compatible Mixed port**. A SOCKS-only port is not supported by this launcher as currently configured.
- Make sure your VPN/proxy client is running before launching Antigravity.
- Fully close Antigravity before running the launcher again.
- The launcher does not bypass Google account restrictions, regional restrictions, or service eligibility requirements.
- A successful local proxy check does not guarantee that Google services are accessible.
- A `403 Forbidden` response may indicate an access restriction unrelated to the launcher.

## 🛠️ Troubleshooting

<details>
<summary><strong>Antigravity does not start</strong></summary>

- Make sure Antigravity is installed.
- Check whether the executable path is correct.
- Try setting `ANTIGRAVITY_EXE` manually.

</details>

<details>
<summary><strong>Local proxy connection failed</strong></summary>

- Start your VPN application.
- Enable its HTTP or Mixed proxy port.
- Verify `PROXY_HOST` and `PROXY_PORT`.
- Make sure another application is not blocking the local connection.

</details>

<details>
<summary><strong>Antigravity opens but still cannot connect</strong></summary>

- Verify that you are using an HTTP-compatible port, not a SOCKS-only port.
- Close all Antigravity processes.
- Start Antigravity again using the launcher.
- Check whether your proxy client routes the required Google domains correctly.

</details>

---

## 🔒 Privacy & Security

This project:

- Does not collect user information.
- Does not request Google credentials.
- Does not store passwords or API keys.
- Does not modify permanent Windows network settings.
- Does not include tracking or telemetry.

Always review scripts before running them and use trusted proxy services.

## 🤝 Contributing

Contributions, bug reports, and suggestions are welcome!

If you encounter a compatibility issue:

1. Open a GitHub Issue.
2. Include your Windows version.
3. Include your proxy client and local proxy type.
4. Describe the problem and relevant error messages.

Please do not share passwords, private proxy URLs, or personal account information.

## 📄 License

Distributed under the **MIT License**. See the [LICENSE](LICENSE) file for details.

---

<p align="center">
  Made with ❤️ for the Antigravity community.
</p>
