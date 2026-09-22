# Technical Artifacts

These artifacts support the reconstructed lab exercises in this repository. They use invented addresses and identifiers and must be tested in an authorized lab before deployment.

## Files

- [`segmentation-validation.sh`](segmentation-validation.sh) — a dry-run-by-default checklist for five cross-zone reachability tests. It sends traffic only when called with `--execute`.
- [`wazuh-local-rules.xml`](wazuh-local-rules.xml) — an example Wazuh correlation rule for repeated authentication failures from the same decoded source address.

## Safety Notes

- Review every target before using `--execute`.
- Use only on systems and networks you own or have permission to test.
- Confirm Wazuh parent rule IDs and decoded fields in the installed version.
- Run Wazuh rules through `wazuh-logtest` before loading them.
- Keep real logs and infrastructure details outside the public repository.

The Wazuh custom-rule ID range and syntax follow the current official documentation:

- [Custom rules](https://documentation.wazuh.com/current/user-manual/ruleset/rules/custom.html)
- [Ruleset XML syntax](https://documentation.wazuh.com/current/user-manual/ruleset/ruleset-xml-syntax/rules.html)
