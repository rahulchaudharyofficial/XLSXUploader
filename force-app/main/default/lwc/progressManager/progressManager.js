import { api, LightningElement } from "lwc";

export default class ProgressManager extends LightningElement {
  variant = "base";
  hasError = false;
  progressType = "path";

  @api hasSteps;
  @api progressSteps;
  @api currentStep;
}