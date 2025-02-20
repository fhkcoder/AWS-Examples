import { Stack, StackProps } from 'aws-cdk-lib'; // Import AWS CDK Stack and its properties
import * as s3 from 'aws-cdk-lib/aws-s3'; // Import the S3 module from AWS CDK
import { Construct } from 'constructs'; // Import the Construct class, which is a base class for all constructs in CDK

/**
 * Represents an AWS CloudFormation stack using AWS CDK.
 * This stack creates an Amazon S3 bucket.
 */
export class CdkStack extends Stack {
  /**
   * Constructor for the CDK Stack.
   * @param scope The parent construct, typically the App.
   * @param id The unique identifier for this stack.
   * @param props Optional properties for configuring the stack.
   */
  constructor(scope: Construct, id: string, props?: StackProps) {
    super(scope, id, props); // Call the parent Stack constructor
    
    /**
     * Creates a new S3 bucket within this stack.
     * The bucket is given a unique logical ID within the stack: 'MyBucket'.
     */
    const bucket = new s3.Bucket(this, 'MyBucket');
  }
}
